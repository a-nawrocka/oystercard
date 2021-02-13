require 'journey'

describe Journey do
  let(:station) { double :station, zone: 1}

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting a journey" do
    expect(subject.finish(station)).to eq(subject)  
  end

  context 'given an entry station' do
    subject {described_class.new(entry_station: station)}

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end

    it 'returns penalty fare if no exit station given' do 
      expect(subject.fare).to eq Journey::PENALTY_FARE 
    end

    context 'given an exit station' do 
      let(:exit_station) { double :exit_station }
      before do
        subject.finish(exit_station)
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq 1
      end

      it 'knows that journey is complete' do 
        expect(subject.complete?).to eq true
      end
    end
  end
end 