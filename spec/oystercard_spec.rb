require 'oystercard'

describe Oystercard do
  it 'oyster card displays balance' do 
    expect(subject.balance).to eq(0)
  end
  
  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
      
    it 'top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end
      
    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up maximum_balance
      raise_error(RuntimeError, "Maximum balance of #{maximum_balance} exceeded")
    end
      
  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }
    it 'deducts an amount from the balance' do
    subject.top_up(20)
    expect{ subject.deduct 3}.to change{ subject.balance }.by (-3)
    end
  end
  
    describe '#in_journey' do
      it 'is initially not in a journey' do
        expect(subject).not_to be_in_journey
      end
    
      it 'will not touch in if below minimum balance' do
        expect{ subject.touch_in }.to raise_error "Insufficient balance to touch in"
      end
