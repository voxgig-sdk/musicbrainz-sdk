
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { MusicbrainzSDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await MusicbrainzSDK.test()
    equal(null !== testsdk, true)
  })

})
