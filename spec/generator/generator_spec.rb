require 'spec_helper'

describe Uniqueness do
  context 'generate' do
    it { expect(Uniqueness.generate).not_to be_nil }
    it { expect(Uniqueness.generate(type: :numbers)).to match(/^[0-9]+$/) }
    it { expect(Uniqueness.generate(prefix: 'hassan').index('hassan')).to eq 0 }
    it { expect(Uniqueness.generate(suffix: 'hassan')).to end_with "hassan" }
    it { expect(Uniqueness.generate(chars: 'A'..'F')).to match(/^[A-F]+$/) }
    it { expect(Uniqueness.generate(chars: ('A'..'F').to_a)).to match(/^[A-F]+$/) }
    it { expect(Uniqueness.generate(chars: 'ABCDEF')).to match(/^[A-F]+$/) }
  end
end
