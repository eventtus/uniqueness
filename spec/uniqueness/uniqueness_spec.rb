require 'spec_helper'

describe Uniqueness do
  let(:page) { Page.create }
  let(:new_page) { NewPage.new }

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

    context 'excludes ambiguous characters from human field' do
      it { expect(page.short_code.split).not_to include Uniqueness.uniqueness_ambigious_dictionary  }
    end
  end
  context 'update' do
    it { expect(page.uid).not_to be_nil }
    it { expect(page.short_code).not_to be_nil }
    it { expect(page.token).not_to be_nil }

    context 'does not overwrite old value' do
      let(:old_uid) { page.uid }
      before do
        page.save!
      end
      it { expect(page.uid).to eq old_uid }
    end
  end

  context 'regenerate' do
    it { expect(page.uid).not_to be_nil }
    it { expect(page.short_code).not_to be_nil }
    it { expect(page.token).not_to be_nil }

    context 'regenerates a new unique value' do
      let!(:old_uid) { page.uid }
      before { page.regenerate_uid }

      it { expect(page.uid).not_to eq old_uid }
    end

    context 'regenerates a new unique value with the same options' do
      let!(:old_short_code) { page.short_code }
      let!(:old_token) { page.token }
      before do
        page.regenerate_short_code
        page.regenerate_token
      end

      it { expect(page.short_code).not_to eq old_short_code }
      it { expect(page.short_code.length).to eq 9 }
      it { expect(page.short_code.split).not_to include Uniqueness.uniqueness_ambigious_dictionary  }
      it { expect(page.token).not_to eq old_token }
      it { expect(page.token.length).to eq 12 }
    end
  end

  context 'initialized new object' do
    it { expect(new_page.after_init_token).not_to be_nil }

    context 'length' do
      it 'defaults to 32' do
        expect(new_page.after_init_token.length).to eq 32
      end

      it 'new_page to be new record and not persisted' do
        expect(new_page.new_record?).to be_truthy
        expect(new_page.id).to be_nil
      end
    end

    context 'excludes ambiguous characters from human field' do
      it { expect(page.short_code.split).not_to include Uniqueness.uniqueness_ambigious_dictionary  }
    end
  end
end
