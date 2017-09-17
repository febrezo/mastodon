# frozen_string_literal: true
# == Schema Information
#
# Table name: custom_emojis
#
#  id                 :integer          not null, primary key
#  shortcode          :string           default(""), not null
#  domain             :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class CustomEmoji < ApplicationRecord
  has_attached_file :image

  validates_attachment :image, content_type: { content_type: 'image/png' }, presence: true, size: { in: 0..50.kilobytes }
  validates :shortcode, uniqueness: { scope: :domain }, format: { with: /\A[a-zA-Z0-9_]{2,}\z/ }, length: { minimum: 2 }

  include Remotable

  class << self
    def from_text(text, domain)
      return [] if text.blank?
      shortcodes = text.scan(/(?<=[^[:alnum:]:]|\n|^):([a-zA-Z0-9_]{2,}):(?=[^[:alnum:]:]|$)/).map(&:first)
      where(shortcode: shortcodes, domain: domain)
    end
  end
end
