require "Oystercard"
describe Oystercard do
  context "when initialized" do
    it "set balance to zero" do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    context 'when given argument of 20' do
      before { subject.top_up(20) }
      it 'adds 20 to balance' do
        expect(subject.balance).to be 20
      end
    end
    context 'when amount is more than maximum limit ' do
      it 'raises an error' do
        expect { (subject.top_up(91)) }.to raise_error "91 is over limit!"
      end
    end
  end

  describe '#deduct' do
    before { subject.top_up(30) }

    context 'when given argument 20' do
      before { subject.deduct(20) }
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
      before { subject.touch_in }
      it 'changes to true' do
        expect(subject.send(:in_journey?)).to be true
      end

      context 'after touching out' do
        it 'changes back to false' do
          expect(subject.send(:touch_out)).to be false
        end
      end
    end
  end
end
