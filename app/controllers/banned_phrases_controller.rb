class BannedPhrasesController < ApplicationController
  def show
    @phrases = BannedPhrases.all
  end

  def new
    @phrase = BannedPhrases.new
  end

  def create
    @phrase = BannedPhrases.new(phrase_params)
    if @phrase.save
      flash.notice = 'Banned Phrase Submitted!'
    else
      flash.now[:error] = 'Problem with submission.'
    end
  end

  private

  def phrase_params
    params.require(:phrase).permit(:phrase)
  end
end
