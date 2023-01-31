# frozen_string_literal: true

shared_context :last_of_us_complete do
  let(:sony_publisher) { create :publisher, :sony }
  let(:naughty_dog) { create :developer, :naughty_dog }
  let(:last_of_us) { create :game, :last_of_us }
  let(:naughty_developer_companiable) { create(:companiable, game: last_of_us, company: naughty_dog, main: true) }
  let(:sony_publisher_companiable) {  create(:companiable, game: last_of_us, company: sony_publisher) }
  let(:action_genre) { create(:genre, name: 'Action', games: [last_of_us]) }
  let(:survivor_genre) { create(:genre, name: 'Survivor', games: [last_of_us]) }

  before do
    naughty_developer_companiable
    sony_publisher_companiable
    sony_publisher.developers.push(naughty_dog)
    action_genre
    survivor_genre
  end
end
