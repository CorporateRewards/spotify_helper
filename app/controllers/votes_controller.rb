class VotesController < ApplicationController

  def new
    track = params[:uid] ?  Track.find_or_create_by(track_id: params[:uid], uri: params[:uri]) : Track.find_or_create_by(id: params[:dbid])
    user = current_user ? current_user : User.find_by(email: current_admin.email)
    vote = track.votes.find_or_create_by(user: user)
    if vote.update(vote: params[:vote])
      flash.notice = "Thanks for your vote!"
      redirect_to :back
    else
      flash.notice = "Sorry, something went wrong, try again please"
      redirect_to :back
    end
  end

  def place_vote
    @playlist = Track.sorted_by_most_votes
    @user = current_user ? current_user : User.find_by(email: current_admin.email)
    @votes = @user.votes.all
    track = params[:uid] ?  Track.find_or_create_by(track_id: params[:uid], uri: params[:uri]) : Track.find_or_create_by(id: params[:dbid])
    user = current_user ? current_user : User.find_by(email: current_admin.email)
    vote = track.votes.find_or_initialize_by(user: user)
    if vote.update(vote: params[:vote])
      respond_to :js
    else
      flash.notice = "Sorry, something went wrong, try again please"
      redirect_to :back
    end
  end


  def destroy
    track = Track.find(params[:dbid])
    track.destroy
    redirect_to root_url
  end

end
