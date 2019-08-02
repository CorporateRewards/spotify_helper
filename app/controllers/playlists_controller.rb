class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]
  skip_before_action :currently_playing
  # GET /playlists
  # GET /playlists.json
  def index
    @playlists = spotify_user.playlists
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show; end

  # GET /playlists/new
  def new; end

  # GET /playlists/1/edit
  def edit; end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = spotify_user.create_playlist!(params[:playlist_name], public: false)
  end

  # PATCH/PUT /playlists/1
  # PATCH/PUT /playlists/1.json
  def update
    @playlist.change_details!(name: params[:playlist_name], public: false)
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_playlist
    @playlist = RSpotify::Playlist.find(ENV['spotify_username'], params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def playlist_params
    params.fetch(:playlist, {})
  end
end
