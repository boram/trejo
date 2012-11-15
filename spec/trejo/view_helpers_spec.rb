require 'spec_helper'

include ActionView::Helpers::UrlHelper
class TrejoHelperTestClass; end

describe Trejo::ViewHelpers do
  before do
    @trejo = TrejoHelperTestClass.new
    @trejo.extend Trejo::ViewHelpers
  end

  describe '#nav_item' do
    context 'by default' do
      before do
        request = stub fullpath: '/home'
        @trejo.stub(:request).and_return(request)
      end

      context 'when the current path matches the url' do
        before do
          @nav_item = @trejo.nav_item('Home', '/home')
        end

        it 'returns a selected nav item' do
          expect(@nav_item).to eq('<a href="/home" class="active">Home</a>')
        end
      end

      context 'when the current path does not match the url' do
        before do
          @nav_item = @trejo.nav_item('Blog', '/blog')
        end

        it 'returns a selected nav item' do
          expect(@nav_item).to eq('<a href="/blog">Blog</a>')
        end
      end
    end

    context 'with a selection criteria regex' do
      before do
        request = stub fullpath: '/home?page=2'
        @trejo.stub(:request).and_return(request)
      end

      context 'when the current page matches the url' do
        before do
          @nav_item = @trejo.nav_item('Home', '/home', selected: /^\/home/)
        end

        it 'returns a selected nav item' do
          expect(@nav_item).to eq('<a href="/home" class="active">Home</a>')
        end
      end

      context 'when the current path does not match the url' do
        before do
          @nav_item = @trejo.nav_item('Blog', '/blog', selected: /^\/blog/)
        end

        it 'returns a unselected nav item' do
          expect(@nav_item).to eq('<a href="/blog">Blog</a>')
        end
      end
    end
  end
end
