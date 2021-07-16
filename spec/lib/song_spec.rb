# frozen_string_literal: true

RSpec.describe SongPro::Song do
  context "#chord" do
    it "returns all chords through the song" do
      song = SongPro.parse('
# Chords

Some [D] chord [A]
| [B] [C] |
')

      expect(song.chords).to eq(%w[D A B C])
    end
  end

  context "#to_html" do
    it "generates divs" do
      infile = File.read("spec/fixtures/bad-moon-rising.sng")
      outfile = File.read("spec/fixtures/bad-moon-rising.html")
      song = SongPro.parse(infile)

      html = song.to_html

      expect(html).to include outfile
    end
  end
end
