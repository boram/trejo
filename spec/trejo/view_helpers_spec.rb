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
      context 'when the link path matches the requested path' do
        before do
          request = stub fullpath: '/home'
          @trejo.stub(:request).and_return(request)

          @nav_item = @trejo.nav_item('Home', '/home')
        end

        it 'returns a selected nav item' do
          expect(@nav_item).to eq('<a href="/home" class="active">Home</a>')
        end
      end

      context 'when the link path does not match the requested path' do
        before do
          request = stub fullpath: '/home'
          @trejo.stub(:request).and_return(request)

          @nav_item = @trejo.nav_item('Blog', '/blog')
        end

        it 'returns an unselected nav item' do
          expect(@nav_item).to eq('<a href="/blog">Blog</a>')
        end
      end

      context 'ignores query parameters' do
        context 'and when the link path matches the requested path' do
          before do
            request = stub fullpath: '/home?page=2'
            @trejo.stub(:request).and_return(request)

            @nav_item = @trejo.nav_item('Home', '/home')
          end

          it 'returns a selected nav item' do
            expect(@nav_item).to eq('<a href="/home" class="active">Home</a>')
          end
        end
      end

      context 'assumes the link path is the root' do
        context 'and when the requested path includes a nested path' do
          before do
            request = stub fullpath: '/home/index'
            @trejo.stub(:request).and_return(request)
            @nav_item = @trejo.nav_item('Home', '/home')
          end

          it 'returns a selected nav item' do
            expect(@nav_item).to eq('<a href="/home" class="active">Home</a>')
          end
        end

        context 'and when the requested path includes a different root path' do
          before do
            request = stub fullpath: '/blog/index'
            @trejo.stub(:request).and_return(request)
            @nav_item = @trejo.nav_item('Home', '/home')
          end

          it 'returns an unselected nav item' do
            expect(@nav_item).to eq('<a href="/home">Home</a>')
          end
        end

        context 'and when query parameters are present' do
          before do
            request = stub fullpath: '/home/index?foo=bar&walter=sobchak'
            @trejo.stub(:request).and_return(request)
            @nav_item = @trejo.nav_item('Home', '/home')
          end

          it 'returns a selected nav item' do
            expect(@nav_item).to eq('<a href="/home" class="active">Home</a>')
          end
        end
      end
    end

    context 'when the selection criteria is a regex' do
      before do
        request = stub fullpath: '/home?page=2'
        @trejo.stub(:request).and_return(request)
      end

      context 'when the requested path matches the criteria' do
        before do
          @nav_item = @trejo.nav_item('Home', '/home', selected: /^\/home/)
        end

        it 'returns a selected nav item' do
          expect(@nav_item).to eq('<a href="/home" class="active">Home</a>')
        end
      end

      context 'when the requested path does not match the criteria' do
        before do
          @nav_item = @trejo.nav_item('Blog', '/blog', selected: /^\/blog/)
        end

        it 'returns a unselected nav item' do
          expect(@nav_item).to eq('<a href="/blog">Blog</a>')
        end
      end
    end

    context 'when a css class is supplied' do
      before do
        request = stub fullpath: '/home'
        @trejo.stub(:request).and_return(request)

        @nav_item = @trejo.nav_item('Home', '/home', class: 'current-section')
      end

      it 'returns a selected nav item with that class' do
        expect(@nav_item).to eq('<a href="/home" class="current-section">Home</a>')
      end
    end
  end

  describe '#merge_classes' do
    it 'merges strings with strings' do
      expect(@trejo.merge_classes('foo', 'bar')).to eq('foo bar')
      expect(@trejo.merge_classes('foo bar', 'baz')).to eq('foo bar baz')
    end

    it 'merges arrays with strings' do
      expect(@trejo.merge_classes(['foo', 'bar'], 'baz')).to eq('foo bar baz')
    end

    it 'merges arrays with arrays' do
      expect(
        @trejo.merge_classes(['walter', 'sobchak'], ['shomer', ['shabbas']])
      ).to eq('walter sobchak shomer shabbas')
    end

    it 'omits duplicates' do
      expect(
        @trejo.merge_classes(
          'volta', 'cassandra gemini', 'volta', 'cygnus',
          ['volta', 'vismund cygnus', 'cassandra', 'gemini']
        )
      ).to eq('volta cassandra gemini cygnus vismund')
    end

    it 'ignores blank values' do
      expect(
        @trejo.merge_classes(
          'volta', 'cassandra gemini', nil,
          ['', 'cygnus', ' ', 'vismund', nil]
        )
      ).to eq('volta cassandra gemini cygnus vismund')
    end

    it 'strips unnecessary whitespaces' do
      expect(
        @trejo.merge_classes(
          ' volta ', 'cassandra      gemini ',
          ['   cygnus', '  ', '         vismund ']
        )
      ).to eq('volta cassandra gemini cygnus vismund')
    end
  end
end
