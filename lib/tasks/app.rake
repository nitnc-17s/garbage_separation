require 'csv'
require 'nkf'

namespace :app do
  desc 'Clear database'
  task clear: :environment do
    GarbageNote.all.each { |obj| obj.destroy! }
    Garbage.all.each { |obj| obj.destroy! }
    Category.all.each { |obj| obj.destroy! }
    Separation.all.each { |obj| obj.destroy! }
    City.all.each { |obj| obj.destroy! }
  end

  desc 'Load Garbage data'
  task load_garbage: :environment do
    csv_str = ''

    File.open(Rails.root.join('garbage.csv'), "r") do |f|
      csv_str = f.read
    end

    csv = NKF.nkf('-w -d --fb-subchar=0x3013', csv_str) # UTF-8N LF
    csv = CSV.parse(csv, headers: true)

    csv.each do |record|
      name = record['ゴミ名称']
      city_name = record['市町村名']
      category_name = record['カテゴリー(台所ごみ / 電気製品など)']
      separation_name = record['分別 (燃えるごみ / 燃えないごみなど)']
      note = record['備考 (ゴミごとに固有のもののみ)']

      # 表記揺れを許さない市民の会
      # 分別
      separation_name = separation_name.gsub(/ゴミ/, 'ごみ')
      separation_name = '燃えないごみ(カン・ビン)'  if separation_name == '燃えないごみ（カン・ビン）'
      separation_name = '使用済小型家電'  if separation_name == '使用済み小型家電'
      separation_name = '持込のみ可'  if separation_name == '持ち込みのみ可'
      separation_name = '市では収集できません'  if (separation_name == '回収不可' || separation_name == '収集不可')
      # カテゴリー
      category_name = category_name.gsub(/＆/, '・')
      category_name = category_name.gsub(/、/, '・')
      category_name = category_name.gsub(/おもちゃ/, 'ホビー')
      category_name = category_name.gsub(/パソコン/, 'PC')
      category_name = category_name.gsub(/電気製品/, '電化製品')
      # 表記揺れを許さない市民の会

      garbage = Garbage.register_garbage(name, city_name, category_name, separation_name)
      garbage.garbage_notes.create!(note: note, note_type: 'text')  if note.present?
    end
  end
end
