package timist

import "time"

type Timist struct {
	*time.Time
}

func FromTime(t *time.Time) *Timist {
	return &Timist{
		t,
	}
}

func Now() *Timist {
	now := time.Now()
	return &Timist{
		&now,
	}
}

func (ts *Timist) GetTime() *time.Time {
	return ts.Time
}
