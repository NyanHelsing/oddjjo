using PortAudio

# Audio parameters
const SAMPLE_RATE = 44100           # Samples per second
const FREQUENCY = 2000.0            # Frequency in Hertz
const DURATION = 2.0                # Duration in seconds

const MASTER_OUTPUT = 0.75               # Amplitude (range: 0.0 to 1.0)

const DECAY = -5
amp_env = exp.(DECAY * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE)

waveform = sin.(2pi * FREQUENCY * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE) .* amp_env * MASTER_OUTPUT

PortAudioStream(0, 2; samplerate=SAMPLE_RATE, latency=0.1) do stream
    write(stream, waveform)
end
