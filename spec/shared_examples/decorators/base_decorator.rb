# frozen_string_literal: true

shared_examples_for 'error decorator code' do |code|
  it { expect(subject.code).to eq code }
end

shared_examples_for 'error decorator i18n label' do |label|
  it { expect(subject.i18n_label).to eq label }
end

shared_examples_for 'error decorator level' do |level|
  it { expect(subject.level).to eq level }
end

shared_examples_for 'error decorator status' do |status|
  it { expect(subject.status).to eq status }
end
