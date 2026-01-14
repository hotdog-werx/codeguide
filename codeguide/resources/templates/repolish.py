from datetime import UTC, datetime

from codeguide.repolish_utils import get_owner_repo


def create_context() -> dict[str, str]:
    """Base context for repolish."""
    owner, repo = get_owner_repo()
    return {
        'owner': owner,
        'repo': repo,
        'codeguide_ref': 'master',
        'year': str(datetime.now(tz=UTC).year),
        'ci_operating_systems': '["ubuntu-latest"]',
        'build_command': 'poe build',
        'publish_command': 'poe publish',
    }
