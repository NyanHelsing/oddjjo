using PortAudio

# Audio parameters
const SAMPLE_RATE = 44100           # Samples per second
const FREQUENCY = 1000.0            # Frequency in Hertz
const DURATION = 0.666                # Duration in seconds

const MASTER_OUTPUT = 0.75               # Amplitude (range: 0.0 to 1.0)

const DECAY = -5
amp_env = exp.(DECAY * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE)

waveform = sin.(2pi * FREQUENCY * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE) .* amp_env * MASTER_OUTPUT

# Play three chords sequentially
PortAudioStream("pulse"; samplerate=SAMPLE_RATE, latency=0.1) do stream
    waveformA = sin.(2pi * FREQUENCY * 1 * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE) .* amp_env * MASTER_OUTPUT
    waveformB = sin.(2pi * FREQUENCY * 1.8 * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE) .* amp_env * MASTER_OUTPUT
    waveformC = sin.(2pi * FREQUENCY * .666 * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE) .* amp_env * MASTER_OUTPUT
    mixed_waveform = (waveformA + waveformB + waveformC) / 3
    write(stream, mixed_waveform)

    waveformA = sin.(2pi * FREQUENCY * 1.5 * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE) .* amp_env * MASTER_OUTPUT
    waveformB = sin.(2pi * FREQUENCY * 1.125 * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE) .* amp_env * MASTER_OUTPUT
    waveformC = sin.(2pi * FREQUENCY * .75 * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE) .* amp_env * MASTER_OUTPUT
    mixed_waveform = (waveformA + waveformB + waveformC) / 3
    write(stream, mixed_waveform)

    waveformA = sin.(2pi * FREQUENCY * 1.333 * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE) .* amp_env * MASTER_OUTPUT
    waveformB = sin.(2pi * FREQUENCY * 1.666 * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE) .* amp_env * MASTER_OUTPUT
    waveformC = sin.(2pi * FREQUENCY * 1.0 * (1:DURATION*SAMPLE_RATE) / SAMPLE_RATE) .* amp_env * MASTER_OUTPUT
    mixed_waveform = (waveformA + waveformB + waveformC) / 3
    write(stream, mixed_waveform)
end
