# frozen_string_literal: true

RSpec.describe Song do
  context '#to_html' do
    it 'generates divs' do
      infile = File.read('spec/fixtures/bad-moon-rising.sng')
      outfile = File.read('spec/fixtures/bad-moon-rising.html')
      song = SongPro.parse(infile)

      html = song.to_html

      expect(html).to include outfile
    end
  end

  context '#chords' do
    it 'returns an sorted array of all chords in the song' do
      infile = File.read('spec/fixtures/bad-moon-rising.sng')
      song = SongPro.parse(infile)

      expect(song.chords).to eq %w[A A7 D G]
    end
  end
end
