require "Oystercard"

describe Oystercard do
  let(:entry_station) { double :station}
  let(:exit_station) { double :station}
 
  context "when initialized" do
    it "set balance to zero" do
      expect(subject.balance).to eq 0
    end
    it 'has an empty list of journeys by default' do 
      expect(subject.journeys).to be_empty
    end
  end

  describe '#top_up' do
    context 'with argument 20' do
      before { subject.top_up(20) }
      it 'adds 20 to balance' do
        expect(subject.balance).to be 20
      end
    end

    context 'when amount is more than maximum limit ' do
      it 'raises an error' do
        expect { (subject.top_up(subject.limit + 1)) }.to raise_error "91 is over limit!"
      end
    end
  end

  describe '#touch_in' do
    context 'when balance is less than minimum journey fare' do
      it 'raises and error' do
        expect { subject.touch_in(entry_station) }.to raise_error 'Not enough money'
      end
    end
    context 'when balance is above minimum journey fare' do 
      before { subject.top_up(20) }
      it 'saves entry station' do 
        expect { subject.touch_in(entry_station) }.to change {subject.entry_station }.to (entry_station)
        end 
      end 
  end

  describe '#touch_out' do
    it 'deducts minimum fare from balance' do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-1)
    end
    before do  
      subject.top_up(20) 
      subject.touch_in(entry_station) 
    end

    it 'stores exit station' do 
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
    it 'stores a journey' do 
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end

  end

  describe '#deduct' do
    before { subject.top_up(30) }

    context 'when given argument 20' do
      before { subject.send(:deduct, 20) }
      it 'deducts 20 from balance' do
        expect(subject.balance).to be 10
      end
    end
  end

  describe '#in_journey?' do
    context 'before touching in' do
      subject { described_class.new.send(:in_journey?) }
      it { is_expected.to be false }
    end

    context 'after touching in' do
      before { subject.top_up(20) }
      before { subject.touch_in(entry_station) }
      it 'changes to true' do
        expect(subject.send(:in_journey?)).to be true
      end

      context 'then touching out' do
        it 'changes back to false' do
          expect(subject.touch_out(exit_station)).to be false
        end
      end
    end
  end
end
