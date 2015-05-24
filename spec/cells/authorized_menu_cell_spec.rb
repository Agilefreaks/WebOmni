require 'spec_helper'

describe AuthorizedMenuCell, type: :cell do
  context 'cell rendering' do
    context 'rendering show' do
      subject { cell(:authorized_menu).call(:show) }
    end
  end
end