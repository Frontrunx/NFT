// Utility functions
function generateSample() {
    return {
        name: 'Sample NFT',
        attributes: [
            { trait_type: 'Background', value: 'Blue' },
            { trait_type: 'Rarity', value: 'Common' }
        ]
    };
}

module.exports = { generateSample };
