# frozen_string_literal: true

require 'rails_helper'

describe DecoratorFinder do
  describe '#decorate_for' do
    context 'DecoratableClass' do
      subject { DecoratableClass.new.decorate_for(:scope) }

      it { is_expected.to be_decorated }
      it { is_expected.to be_a Scope::DecoratableClassDecorator }
    end

    context 'NonDecoratableClass' do
      subject { NonDecoratableClass.new.decorate_for(:scope) }

      it { is_expected.to be_nil  }
    end

    context 'ScopeWithObjectDecorator' do
      subject { NonDecoratableClass.new.decorate_for(:with_object_decorator) }

      it { is_expected.to be_a WithObjectDecorator::ObjectDecorator }
    end
  end

  describe '.decorate_for' do
    context 'DecoratableClass' do
      subject { described_class.decorate_for(DecoratableClass.new, :scope) }

      it { is_expected.to be_decorated }
      it { is_expected.to be_a Scope::DecoratableClassDecorator }
    end

    context 'NonDecoratableClass' do
      subject { described_class.decorate_for(NonDecoratableClass.new, :scope) }

      it { is_expected.to be_nil  }
    end

    context 'ScopeWithObjectDecorator' do
      subject do
        described_class.decorate_for(NonDecoratableClass.new, :with_object_decorator)
      end

      it { is_expected.to be_a WithObjectDecorator::ObjectDecorator }
    end
  end
end
