require 'spec_helper'

describe Uniqueness do
  context 'generate' do
    it { expect(Uniqueness.generate).not_to be_nil }
  end
end
