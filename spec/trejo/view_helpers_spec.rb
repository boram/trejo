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

      context 'when the link path matches the current path' do
        before do
          @nav_item = @trejo.nav_item('Home', '/home')
        end

        it 'returns a selected nav item' do
          expect(@nav_item).to eq('<a href="/home" class="active">Home</a>')
        end
      end

      context 'when the link path does not match the current path' do
        before do
          @nav_item = @trejo.nav_item('Blog', '/blog')
        end

        it 'returns an unselected nav item' do
          expect(@nav_item).to eq('<a href="/blog">Blog</a>')
        end
      end
    end

    context 'when query parameters are ignored' do
      context 'and the link path matches the current path' do
        before do
          request = stub fullpath: '/home?page=2'
          @trejo.stub(:request).and_return(request)
          @nav_item = @trejo.nav_item('Home', '/home', ignore_params: true)
        end

        it 'returns a selected nav item' do
          expect(@nav_item).to eq('<a href="/home" class="active">Home</a>')
        end
      end

      context 'and the current path includes a nested path' do
        before do
          request = stub fullpath: '/home/index?page=2'
          @trejo.stub(:request).and_return(request)
          @nav_item = @trejo.nav_item('Home', '/home', ignore_params: true)
        end

        it 'returns an unselected nav item' do
          expect(@nav_item).to eq('<a href="/home">Home</a>')
        end
      end
    end

    context 'when the selection criteria is specified as the root path' do
      context 'and the current path includes a nested path' do
        before do
          request = stub fullpath: '/documents/2/edit'
          @trejo.stub(:request).and_return(request)
          @nav_item = @trejo.nav_item('Documents', '/documents', root_path: true)
        end

        it 'returns a selected nav item' do
          expect(@nav_item).to eq('<a href="/documents" class="active">Documents</a>')
        end
      end

      context 'and query parameters are ignored' do
        context 'and current path includes a nested path' do
          before do
            request = stub fullpath: '/documents/2/edit?foo=bar'
            @trejo.stub(:request).and_return(request)
            @nav_item = @trejo.nav_item('Documents', '/documents', root_path: true, ignore_params: true)
          end

          it 'returns a selected nav item' do
            expect(@nav_item).to eq('<a href="/documents" class="active">Documents</a>')
          end
        end
      end
    end

    context 'when the selection criteria is a regex' do
      before do
        request = stub fullpath: '/home?page=2'
        @trejo.stub(:request).and_return(request)
      end

      context 'when the current path matches the criteria' do
        before do
          @nav_item = @trejo.nav_item('Home', '/home', selected: /^\/home/)
        end

        it 'returns a selected nav item' do
          expect(@nav_item).to eq('<a href="/home" class="active">Home</a>')
        end
      end

      context 'when the current path does not match the criteria' do
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
