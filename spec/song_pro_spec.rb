# frozen_string_literal: true

RSpec.describe SongPro do
  context 'attributes' do
    it 'parses attributes' do
      song = SongPro.parse('
@title=Bad Moon Rising
@artist=Creedence Clearwater Revival
@capo=1st Fret
@key=C# Minor
@tempo=120
@year=1975
@album=Foo Bar Baz
@tuning=Eb Standard
')

      expect(song.title).to eq('Bad Moon Rising')
      expect(song.artist).to eq('Creedence Clearwater Revival')
      expect(song.capo).to eq('1st Fret')
      expect(song.key).to eq('C# Minor')
      expect(song.tempo).to eq('120')
      expect(song.year).to eq('1975')
      expect(song.album).to eq('Foo Bar Baz')
      expect(song.tuning).to eq('Eb Standard')
    end
  end

  context 'sections' do
    it 'parses section names' do
      song = SongPro.parse('# Verse 1')

      expect(song.sections.size).to eq 1
      expect(song.sections[0].name).to eq 'Verse 1'
    end

    it 'parses multiple section names' do
      song = SongPro.parse('
# Verse 1
# Chorus
')
      expect(song.sections.size).to eq 2
      expect(song.sections[0].name).to eq 'Verse 1'
      expect(song.sections[1].name).to eq 'Chorus'
    end

    context 'section references' do
      it 'captures sections that reference/repeats other sections' do
        song = SongPro.parse('
# Chorus 1
# Chorus 2 [Chorus 1]
')
        expect(song.sections.size).to eq 2
        expect(song.sections[0].name).to eq 'Chorus 1'
        expect(song.sections[1].name).to eq 'Chorus 2'
        expect(song.sections[1].reference).to eq 'Chorus 1'
      end
    end
  end

  context 'lyrics' do
    it 'parses lyrics' do
      song = SongPro.parse("I don't see! a bad, moon a-rising. (a-rising)")

      expect(song.sections.size).to eq 1
      expect(song.sections[0].lines.size).to eq 1
      expect(song.sections[0].lines[0].parts.size).to eq 1
      expect(song.sections[0].lines[0].parts[0].lyric).to eq "I don't see! a bad, moon a-rising. (a-rising)"
    end

    it 'handles parens in lyics' do
      song = SongPro.parse('singing something (something else)')

      expect(song.sections.size).to eq 1
      expect(song.sections[0].lines.size).to eq 1
      expect(song.sections[0].lines[0].parts.size).to eq 1
      expect(song.sections[0].lines[0].parts[0].lyric).to eq 'singing something (something else)'
    end
  end

  context 'chords' do
    it 'parses chords' do
      song = SongPro.parse('[D] [D/F#] [C] [A7]')
      expect(song.sections.size).to eq 1
      expect(song.sections[0].lines.size).to eq 1
      expect(song.sections[0].lines[0].parts.size).to eq 4
      expect(song.sections[0].lines[0].parts[0].chord).to eq 'D'
      expect(song.sections[0].lines[0].parts[0].lyric).to eq ''
      expect(song.sections[0].lines[0].parts[1].chord).to eq 'D/F#'
      expect(song.sections[0].lines[0].parts[1].lyric).to eq ''
      expect(song.sections[0].lines[0].parts[2].chord).to eq 'C'
      expect(song.sections[0].lines[0].parts[2].lyric).to eq ''
      expect(song.sections[0].lines[0].parts[3].chord).to eq 'A7'
      expect(song.sections[0].lines[0].parts[3].lyric).to eq ''
    end
  end

  context 'chords and lyrics' do
    it 'parses chords and lyrics' do
      song = SongPro.parse("[G]Don't go 'round tonight")
      expect(song.sections.size).to eq 1
      expect(song.sections[0].lines.size).to eq 1
      expect(song.sections[0].lines[0].parts.size).to eq 1
      expect(song.sections[0].lines[0].parts[0].chord).to eq 'G'
      expect(song.sections[0].lines[0].parts[0].lyric).to eq "Don't go 'round tonight"
    end

    it 'parses lyrics before chords' do
      song = SongPro.parse("It's [D]bound to take your life")
      expect(song.sections.size).to eq 1
      expect(song.sections[0].lines.size).to eq 1
      expect(song.sections[0].lines[0].parts.size).to eq 2
      expect(song.sections[0].lines[0].parts[0].chord).to eq ''
      expect(song.sections[0].lines[0].parts[0].lyric).to eq "It's"
      expect(song.sections[0].lines[0].parts[1].chord).to eq 'D'
      expect(song.sections[0].lines[0].parts[1].lyric).to eq 'bound to take your life'
    end
  end

  context 'tablature' do
    it 'parses tablature' do
      song = SongPro.parse('
# Riff

|-3---5-|
|---4---|
')
      expect(song.sections.size).to eq 1
      expect(song.sections[0].lines[0].tablature?).to eq true
      expect(song.sections[0].lines[0].tablature).to eq '|-3---5-|'
      expect(song.sections[0].lines[1].tablature?).to eq true
      expect(song.sections[0].lines[1].tablature).to eq '|---4---|'
    end
  end

  context 'full song' do
    it 'parses the whole song' do
      bmr = File.read('spec/fixtures/bad-moon-rising.sng')
      song = SongPro.parse(bmr)
      expect(song.title).to eq 'Bad Moon Rising'
      expect(song.artist).to eq 'Creedence Clearwater Revival'
      expect(song.capo).to eq '1'
      expect(song.sections.size).to eq 9
    end
  end
end
