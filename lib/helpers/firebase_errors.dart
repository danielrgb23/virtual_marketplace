String getErrorString(String code) {
  switch (code) {
    case 'invalid-email':
      return 'O e-mail fornecido é inválido.';
    case 'user-disabled':
      return 'Esta conta foi desativada.';
    case 'user-not-found':
      return 'Não há usuário com este e-mail.';
    case 'wrong-password':
      return 'A senha fornecida está incorreta.';
    case 'email-already-in-use':
      return 'O e-mail já está sendo utilizado por outra conta.';
    case 'operation-not-allowed':
      return 'Operação não permitida. O tipo de autenticação está desabilitado.';
    case 'weak-password':
      return 'A senha fornecida é muito fraca.';
    case 'invalid-verification-code':
      return 'O código de verificação fornecido é inválido.';
    case 'invalid-verification-id':
      return 'O ID de verificação fornecido não é válido.';
    case 'account-exists-with-different-credential':
      return 'Já existe uma conta associada a este e-mail com um provedor de credenciais diferente.';
    case 'credential-already-in-use':
      return 'As credenciais fornecidas já estão associadas a uma conta existente.';
    case 'requires-recent-login':
      return 'O usuário precisa estar logado recentemente para executar esta operação.';
    case 'network-request-failed':
      return 'Falha de rede. Verifique sua conexão com a internet.';
    case 'too-many-requests':
      return 'Muitas solicitações. Tente novamente mais tarde.';
    case 'timeout':
      return 'A operação excedeu o tempo limite. Tente novamente.';
    case 'invalid-credential':
      return 'As credenciais fornecidas são inválidas ou expiraram.';

    default:
      return 'Um erro indefinido ocorreu.';
  }
}
