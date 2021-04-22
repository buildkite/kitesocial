# frozen_string_literal: true

class ChirpPresenter
  def self.to_hash(chirp, options = {})
    new(chirp, options).to_hash
  end

  def initialize(chirp, **options)
    @chirp = chirp
    @options = options
  end

  def to_hash
    { id: @chirp.id,
      content: @chirp.content,
      mentions: mentions,
      author: format_user_hash(@chirp.author),
      created_at: @chirp.created_at.rfc3339,
      updated_at: @chirp.created_at.rfc3339 }
  end

  def mentions
    @chirp.mentions.map { |user| format_user_hash(user) }
  end

  def format_user_hash(user)
    { id: user.id,
      name: user.name,
      url: Rails.application.routes.url_helpers.user_url(user, only_path: true) }
  end
end
