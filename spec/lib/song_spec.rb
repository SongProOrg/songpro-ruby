RSpec.describe SongPro::Song do
  context '#to_html' do
    it 'generates divs' do
      infile = File.read('spec/fixtures/bad-moon-rising.sng')
      outfile = File.read('spec/fixtures/bad-moon-rising.html')
      song = SongPro.parse(infile)

      html = song.to_html

      expect(html).to include outfile
    end
  end
end
