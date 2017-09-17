require 'rails_helper'

RSpec.describe CustomEmoji, type: :model do
  describe '.from_text' do
    let!(:emojo) { Fabricate(:custom_emoji) }

    it 'returns records used via shortcodes in text' do
      expect(described_class.from_text('Hello :coolcat:', nil)).to include(emojo)
    end
  end
end
