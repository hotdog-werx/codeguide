from codeguide.repolish_utils import get_owner_repo


def create_context() -> dict[str, str]:
    """Base context for repolish."""
    owner, repo = get_owner_repo()
    return {'owner': owner, 'repo': repo, 'codeguide_ref': 'master'}
