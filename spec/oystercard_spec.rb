require "Oystercard"
describe Oystercard do
  context "when initialized" do
    it "set balance od zero" do
      expect(subject.balance).to eq 0
    end    
  end 
end
