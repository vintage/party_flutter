import json
import collections

import click

LANGUAGES = ['en', 'pl']


def _get_duplicates(data):
    return [
        item for item, count in collections.Counter(data).items() if count > 1
    ]


@click.group()
def cli():
    pass


@cli.command()
def clean():
    for language in LANGUAGES:
        clean_category(language)


def clean_category(language):
    print('---> Cleaning: {}'.format(language))

    categories_path = '../assets/data/categories_{}.json'.format(language)

    with open(categories_path, 'r') as f:
        categories = json.load(f)

    for category in categories:
        unique_questions = sorted(set(category['questions']))
        unique_questions = [(q[0].upper() + q[1:]).strip() for q in unique_questions]

        prevent_semi_duplicates = []
        for question in unique_questions:
            question = question.lower()
            question = "".join(question.split())

            prevent_semi_duplicates.append(question)

        if len(set(prevent_semi_duplicates)) != len(unique_questions):
            print(_get_duplicates(prevent_semi_duplicates))
            print(_get_duplicates(unique_questions))
            raise Exception('Semi duplicates in category {}'.format(category['name']))

        category['questions'] = unique_questions

    with open(categories_path, 'w') as f:
        f.write(json.dumps(categories, indent=2, sort_keys=True, ensure_ascii=False))

    # Sort categories by number of questions
    categories = sorted(categories, key=lambda k: len(k['questions']), reverse=True)

    for category in categories:
        print('{}: {}'.format(category['id'], len(category['questions'])))

    questions_count = sum(len(c['questions']) for c in categories)

    print('---> Questions count: {}'.format(questions_count))


if __name__ == '__main__':
    cli()
