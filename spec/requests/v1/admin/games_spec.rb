# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin Games', type: :request do
  let(:error_message) do
    {
      errors: [
        { field: 'name', code: 'invalid_resource', message: 'can\'t be blank' },
        { field: 'url', code: 'invalid_resource', message: 'can\'t be blank' },
        { field: 'short_plot', code: 'invalid_resource', message: 'can\'t be blank' },
        { field: 'plot', code: 'invalid_resource', message: 'can\'t be blank' },
      ]
    }
  end

  describe '#create' do
    let(:params) { instance.as_json.with_indifferent_access }
    let(:request!) { post '/v1/admin/games', params: { game: params } }
    let(:instance) { build(:game) }

    before { request! }

    context 'when all is OK' do
      it do
        expect(response).to have_http_status 201
        expect(response).to match_response_schema('game')
        expect(response.body).to eq V1::GameSerializer.new(
          Game.first, { include: %i[developers publishers genres] }
        ).serializable_hash.to_json
      end
    end

    context 'when is not OK' do
      let(:params) { super().except(*%i[name url short_plot plot]) }

      it 'doesn\'t created any element' do
        expect { request! }.to change(Game, :count).by(0)
      end

      it 'returns a json with error messages' do
        expect(response).to have_http_status 422
        expect(response.body).to eq error_message.to_json
      end
    end
  end

  describe '#update' do
    let(:instance) { create(:game) }
    let(:request!) { patch "/v1/admin/games/#{instance.id}", params: { game: params } }

    context 'when type is company' do
      let(:params) do
        {
          name: 'Updated Name',
          url: 'http:://www.updated.com',
          short_plot: 'short plot',
          plot: 'extensive plot',
        }
      end

      it_behaves_like 'updating the parameter', :name
      it_behaves_like 'updating the parameter', :url
      it_behaves_like 'updating the parameter', :short_plot
      it_behaves_like 'updating the parameter', :plot

      before { request! }

      it do
        expect(response).to have_http_status 200
        expect(response).to match_response_schema('game')
      end
    end

    context 'when invalid params' do
      let(:params) { { name: nil, url: nil, short_plot: nil, plot: nil } }

      before { request! }

      it do
        expect(response).to have_http_status 422
        expect(response.body).to eq error_message.to_json
      end
    end
  end
end
