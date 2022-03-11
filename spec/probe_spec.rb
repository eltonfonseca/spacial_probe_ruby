# frozen_string_literal: true

require_relative '../src/probe'

RSpec.describe Probe, type: :model do
  subject { described_class.new moviments }

  let(:moviments) { [] }

  it 'starts with initial position' do
    expect(subject.current_position).to eq({ x: 0, y: 0, face: 'Right' })
  end

  context 'with regular moviments' do
    let(:moviments) { %w[TL M M TR M M M] }

    before { subject.execute_moviments }

    it 'returns current positions successfully' do
      expect(subject.current_position).to eq({ x: 3, y: 2, face: 'Right' })
    end
  end

  context 'with moviments break border on X axis' do
    let(:moviments) { %w[M M M M M] }

    it 'returns invalid moviment error' do
      expect { subject.execute_moviments }.to raise_error(InvalidMoviment)
    end
  end

  context 'with moviments break border on Y axis' do
    let(:moviments) { %w[TL M M M M M] }

    it 'returns invalid moviemtn error' do
      expect { subject.execute_moviments }.to raise_error(InvalidMoviment)
    end
  end

  context 'with invalid arguments' do
    let(:moviments) { ['any text'] }

    it 'returns invalid argument error' do
      expect { subject.execute_moviments }.to raise_error(InvalidArgument)
    end
  end

  describe '.reset' do
    subject(:reset) { probe.reset }

    let(:probe) { described_class.new moviments }
    let(:moviments) { %w[TL M M TR M] }

    before do
      probe.execute_moviments
      reset
    end

    it 'is reseted' do
      expect(probe.current_position).to eq({ x: 0, y: 0, face: 'Right' })
    end
  end
end
