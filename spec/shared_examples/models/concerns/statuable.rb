# frozen_string_literal: true

shared_examples_for 'statuable' do |model|
  it { expect(described_class).to include Statuable }

  describe '.published' do
    context 'when exist a company actived' do
      before do
        create(model, status: 'archived')
        create(model, status: 'pending')
        create(model)
      end

      it 'return array of one published company' do
        expect(described_class.published.size).to eq 1
      end
    end

    context 'when no exist a published company' do
      before  { create(model, status: 'archived') }

      it 'return array of one studio' do
        expect(described_class.published.size).to eq 0
      end
    end
  end

  describe '.by_status' do
    before do
      create(model, status: 'archived')
      create(model, status: 'pending')
      create(model)
    end

    it 'return array of one studio' do
      expect(described_class.by_status(:published).size).to eq 1
    end

    it 'return array of one Publisher' do
      expect(described_class.by_status(:archived).size).to eq 1
    end

    it 'return array of zero Company' do
      expect(described_class.by_status(:pending).size).to eq 1
    end
  end
end
