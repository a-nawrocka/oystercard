require "Oystercard"
describe Oystercard do
  context "when initialized" do
    it "set balance od zero" do
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
        expect { (subject.top_up(91)) }.to raise_error 
      end 
    end  
  end

end
