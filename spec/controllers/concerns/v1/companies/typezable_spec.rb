# frozen_string_literal: true

require 'rails_helper'

describe V1::Companies::Typezable do
  let(:controller) do
    Class.new(V1::BaseController) do
      include V1::Companies::Typezable

      def define_type
        'Studio'
      end
    end
  end

  subject { controller.new }

  it { expect(subject.type).to eq 'Studio' }
end
