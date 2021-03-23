package timist

import "strings"

type Text struct {
	s string
}

func NewText(s string) *Text {
	return &Text{
		s: s,
	}
}

func (txt *Text) Lowercase() *Text {
	txt.s = strings.ToLower(txt.s)
	return txt
}

func (txt *Text) Uppercase() *Text {
	txt.s = strings.ToUpper(txt.s)
	return txt
}

func (txt *Text) Capitalize() *Text {
	str := strings.ToLower(txt.s)
	newStr := []byte(str)

	upStr := strings.ToUpper(txt.s)
	upStrBytes := []byte(upStr)

	caps := false
	for i := 0; i < len(str); i++ {
		if i == 0 || str[i] == ' ' {
			caps = true
		}

		if (str[i] >= 'A' && str[i] <= 'Z') || (str[i] >= 'a' && str[i] <= 'z') &&
			caps {
			newStr[i] = upStrBytes[i]
			caps = false
		}
	}

	txt.s = string(newStr)
	return txt
}

func (txt *Text) GetString() string {
	return txt.s
}
