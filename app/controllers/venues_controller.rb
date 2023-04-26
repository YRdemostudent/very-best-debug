class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list.html.erb" })
  end

  def show
    venue_id = params.fetch("an_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.at(0)

    render({ :template => "venue_templates/details.html.erb" })
  end

  def create
    venue = Venue.new
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save

    redirect_to("/venues/#{venue.name}")
  end
  
  def update
    the_id = params.fetch("the_id")
    venue = Venue.where({ :id => the_id })
    current_venue = venue.at(0)
    address = params.fetch("query_address")
    name = params.fetch("query_name")
    neighborhood = params.fetch("query_neighborhood")
    
    current_venue.address = address
    current_venue.name = name 
    current_venue.neighborhood = neighborhood

    current_venue.save
    
    redirect_to("/venues/#{current_venue.id}")
  end

  def destroy
    the_id = params.fetch("id_to_delete")
    matching_venues = Venue.where({:id => the_id })
    venue = matching_venues.at(0)
    venue.destroy

    redirect_to("/venues")
  end

end
