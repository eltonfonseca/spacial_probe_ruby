# frozen_string_literal: true

require_relative 'errors/invalid_argument'
require_relative 'errors/invalid_moviment'

class Probe
  DIRECTIONS = {
    R: 'Right',
    L: 'Left',
    U: 'Up',
    D: 'Down'
  }.freeze

  TURN_LEFT_DIRECTIONS = {
    D: :R,
    R: :U,
    U: :L,
    L: :D
  }.freeze

  TURN_RIGHT_DIRECTIONS = {
    D: :L,
    L: :U,
    U: :R,
    R: :D
  }.freeze

  BORDER_UP_LIMIT = 5
  BORDER_DOWN_LIMIT = -1

  def initialize(moviments)
    @moviments = moviments
    @face = :R
    @x = 0
    @y = 0
  end

  def current_position
    { x: @x, y: @y, face: DIRECTIONS[@face] }
  end

  def execute_moviments
    @moviments.each do |moviment|
      execute(moviment)
      validate_moviment
    end
  end

  def reset
    @face = :R
    @x = 0
    @y = 0
  end

  private

  def move
    case @face
    when :R
      @x += 1
    when :L
      @x -= 1
    when :U
      @y += 1
    when :D
      @y -= 1
    end
  end

  def execute(moviment)
    case moviment
    when 'M'
      move
    when 'TL'
      turn_left
    when 'TR'
      turn_right
    else
      raise InvalidArgument
    end
  end

  def turn_left
    @face = TURN_LEFT_DIRECTIONS[@face]
  end

  def turn_right
    @face = TURN_RIGHT_DIRECTIONS[@face]
  end

  def validate_moviment
    raise InvalidMoviment if break_border?
  end

  def break_border?
    @x <= BORDER_DOWN_LIMIT ||
      @x >= BORDER_UP_LIMIT ||
      @y <= BORDER_DOWN_LIMIT ||
      @y >= BORDER_UP_LIMIT
  end
end
