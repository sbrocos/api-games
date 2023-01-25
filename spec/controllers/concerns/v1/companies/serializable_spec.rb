# frozen_string_literal: true

require 'rails_helper'

describe V1::Companies::Serializable do
  let(:example) { create(:developer) }
  let(:controller) do
    Class.new(V1::BaseController) do
      include V1::Companies::Typezable
      include V1::Companies::Serializable

      def define_type
        'Developer'
      end
    end
  end

  subject { controller.new }

  describe '#serializer' do
    let(:serializer_json) { V1::DeveloperSerializer.new(example).serializable_hash.to_json }

    it { expect(subject.serializer(example)).to eq serializer_json }
  end

  describe '#serializer_with_options' do
    let(:serializer_json) { V1::DeveloperSerializer.new(example, include: [:publisher]).serializable_hash.to_json }

    it { expect(subject.serializer_with_options(example)).to eq serializer_json }
  end
end
