from setuptools import setup, find_packages

setup(
    name="src",
    version="0.1.0",
    description="package pour l'api source de données",
    author="Younes",
    packages=find_packages(),
    python_requires=">=3.9",
    install_requires=[
        "fastapi==0.104.1",
        "uvicorn[standard]==0.24.0"
    ],
)
