require 'spec_helper'

module Capybara::Poltergeist
  describe Client do
    subject { Client.new(6000) }

    it 'raises an error if phantomjs is too old' do
      subject.stub(:`).with('phantomjs --version').and_return("1.3.0\n")
      expect { subject.start }.to raise_error(PhantomJSTooOld)
    end

    it 'shows the detected version in the version error message' do
      subject.stub(:`).with('phantomjs --version').and_return("1.3.0\n")
      begin
        subject.start
      rescue PhantomJSTooOld => e
        e.message.should include('1.3.0')
      end
    end
  end
end