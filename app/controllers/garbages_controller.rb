require 'json'

class GarbagesController < ApplicationController
  def index
    city_id = params[:city]

    if city_id.blank?
      render status: :bad_request, json: {message: 'Please specify city. `?city=[city-id]`'}
      return
    end

    begin
      city = City.find(city_id)
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: {message: 'The city which you specified is not found.'}
      return
    end

    garbages = []

    city.garbages.each do |garbage|
      garbages.append({id: garbage.id, index: garbage.index, name: garbage.name, category: garbage.category.name, separation: garbage.separation.name})
    end

    render json: {garbages: garbages}
  end

  def show
    garbage_id = params[:id]
    region_id = params[:region]

    begin
      garbage = Garbage.find(garbage_id)
    rescue ActiveRecord::RecordNotFound
      render status: :not_found, json: {message: 'The garbage which you specified is not found.'}
      return
    end

    notes = []

    garbage.garbage_notes.all.each do |note|
      notes.append({note: note.note, type: note.note_type})
    end

    render json: {id: garbage.id, name: garbage.name, category: garbage.category.name, city: garbage.city.name, separation: garbage.separation.name, notes: notes}
  end
end
