# frozen_string_literal: true

shared_examples_for 'updating the parameter' do |param|
  it do
    expect { request! && instance.reload }.to change(instance, param).to(params[param])
  end
end

shared_examples_for 'not updating the parameter' do |param|
  it do
    expect { request! && instance.reload }.not_to change(instance, param)
  end
end

shared_examples_for 'updating the image field' do |param|
  it do
    expect { request! && instance.reload }.to(change { instance.public_send(param).url })
  end
end
