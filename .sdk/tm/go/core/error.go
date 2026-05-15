package core

type MusicbrainzError struct {
	IsMusicbrainzError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewMusicbrainzError(code string, msg string, ctx *Context) *MusicbrainzError {
	return &MusicbrainzError{
		IsMusicbrainzError: true,
		Sdk:              "Musicbrainz",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *MusicbrainzError) Error() string {
	return e.Msg
}
