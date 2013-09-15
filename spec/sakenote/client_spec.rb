require 'spec_helper'

describe Sakenote::Client do
  describe '#new' do
    context "token is provided" do
      it 'dose not raise error' do
        expect{
          Sakenote::Client.new('foobar')
        }.to_not raise_error
      end
    end

    context "when invalid token is provided" do
      it "raises a ConfigurationError exception" do
        expect {
          Sakenote::Client.new(['foo', 'bar'])
        }.to raise_exception(Sakenote::Error::ConfigurationError)
      end
    end

    context "no token is provided" do
      it "raises a ArgumentError exception" do
        expect {
          Sakenote::Client.new
        }.to raise_exception(ArgumentError)
      end
    end
  end

  describe '#sakes' do
    before(:all) do
      @client = Sakenote::Client.new(ENV['SAKENOTE_TOKEN'])
    end

    context 'with no options' do
      before(:all) do
        @sakes = @client.sakes
      end

      it 'contains list of sakes' do
        expect(@sakes.list[0]).to be_a Sakenote::Sake
      end

      it 'contains num_pages' do
        expect(@sakes.num_pages).to be > 0
      end
    end
  end

  describe '#makers' do
    before(:all) do
      @client = Sakenote::Client.new(ENV['SAKENOTE_TOKEN'])
    end

    context 'with no options' do
      before(:all) do
        @makers = @client.makers
      end

      it 'contains list of makers' do
        expect(@makers.list[0]).to be_a Sakenote::Maker
      end

      it 'contains num_pages' do
        expect(@makers.num_pages).to be > 0
      end
    end
  end
end