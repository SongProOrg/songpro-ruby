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
end
