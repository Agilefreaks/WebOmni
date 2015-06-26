require 'spec_helper'

describe UnauthorizedMenuCell, type: :cell do
  context 'cell rendering' do
    context 'rendering show' do
      subject { cell(:unauthorized_menu).call(:show) }
    end
  end
end
