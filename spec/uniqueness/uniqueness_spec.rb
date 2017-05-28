require 'spec_helper'

describe Uniqueness do
  let(:page) { Page.create }

  context 'create' do
    it { expect(page.uid).not_to be_nil }
    it { expect(page.short_code).not_to be_nil }
    it { expect(page.token).not_to be_nil }

    context 'length' do
      it 'defaults to 32' do
        expect(page.uid.length).to eq 32
      end
      it { expect(page.short_code.length).to eq 9 }
      it { expect(page.token.length).to eq 12 }
    end

    context 'excludes ambigious characters from human field', focus: true do
      it { expect(page.short_code.split).not_to include Uniqueness.uniqueness_ambigious_dictionary  }
    end
  end
  context 'update' do
    it { expect(page.uid).not_to be_nil }
    it { expect(page.short_code).not_to be_nil }
    it { expect(page.token).not_to be_nil }

    context 'does not overrite old value' do
      let(:old_uid) { page.uid }
      before do
        page.save
      end
      it { expect(page.uid).to eq old_uid }
    end
  end
end
