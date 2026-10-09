export function encodeLpcUrlContent(content: string): string {
  const bytes = new TextEncoder().encode(content)
  let binary = ''
  for (const byte of bytes) binary += String.fromCharCode(byte)
  return btoa(binary).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '')
}

export function decodeLpcUrlContent(content: string): string {
  if (!/^[\w-]*$/.test(content) || content.length % 4 === 1)
    throw new Error('Invalid Base64URL content')
  const binary = atob(content.replace(/-/g, '+').replace(/_/g, '/'))
  const bytes = Uint8Array.from(binary, (character) => character.charCodeAt(0))
  const decoded = new TextDecoder('utf-8', { fatal: true }).decode(bytes)
  if (encodeLpcUrlContent(decoded) !== content)
    throw new Error('Invalid Base64URL content')
  return decoded
}
