class SongsController < ApplicationController
  before_action :set_song, only: %i[ show edit update destroy ]

  # Should move this to a song download controller probably
  # GET /songs or /songs.json
  def index
    if params[:url].present?
      # Might be worth it to cache this
      description = GetVideoDescription.new.run(params[:url])
      @songs = GetSongListFromDescription.new.run(description)
    else
      @songs = []
    end
  end

  # GET /songs/1 or /songs/1.json
  def show
  end

  # GET /songs/new
  def new
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
  end

  # Should move this to a song download controller probably
  # POST /songs or /songs.json
  def create
    song_list = JSON.parse(params[:song_list], symbolize_names: true)
    DownloadSongList.new(params[:url]).run(song_list)
    redirect_to songs_path(url: params[:url]), notice: 'Download process initiated.'
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to song_url(@song), notice: "Song was successfully updated." }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1 or /songs/1.json
  def destroy
    @song.destroy!

    respond_to do |format|
      format.html { redirect_to songs_url, notice: "Song was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:title, :url)
    end
end
