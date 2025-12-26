// Copyright (c) 2010 Satoshi Nakamoto
// Copyright (c) 2009-2017 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include <chainparams.h>
#include <consensus/merkle.h>

#include <tinyformat.h>
#include <util.h>
#include <utilstrencodings.h>

#include <assert.h>
#include <memory>

#include <chainparamsseeds.h>

#include "arith_uint256.h"

static CBlock CreateGenesisBlock(const char* pszTimestamp, const CScript& genesisOutputScript, uint32_t nTime, uint32_t nNonce, uint32_t nBits, int32_t nVersion, const CAmount& genesisReward)
{
    CMutableTransaction txNew;
    txNew.nVersion = 1;
    txNew.vin.resize(1);
    txNew.vout.resize(1);
    txNew.vin[0].scriptSig = CScript() << 486604799 << CScriptNum(4) << std::vector<unsigned char>((const unsigned char*)pszTimestamp, (const unsigned char*)pszTimestamp + strlen(pszTimestamp));
    txNew.vout[0].nValue = genesisReward;
    txNew.vout[0].scriptPubKey = genesisOutputScript;

    CBlock genesis;
    genesis.nTime    = nTime;
    genesis.nBits    = nBits;
    genesis.nNonce   = nNonce;
    genesis.nVersion = nVersion;
    genesis.vtx.push_back(MakeTransactionRef(std::move(txNew)));
    genesis.hashPrevBlock.SetNull();
    genesis.hashMerkleRoot = BlockMerkleRoot(genesis);
    return genesis;
}

/**
 * Build the genesis block. Note that the output of its generation
 * transaction cannot be spent since it did not originally exist in the
 * database.
 *
 * CBlock(hash=000000000019d6, ver=1, hashPrevBlock=00000000000000, hashMerkleRoot=4a5e1e, nTime=1231006505, nBits=1d00ffff, nNonce=2083236893, vtx=1)
 *   CTransaction(hash=4a5e1e, ver=1, vin.size=1, vout.size=1, nLockTime=0)
 *     CTxIn(COutPoint(000000, -1), coinbase 04ffff001d0104455468652054696d65732030332f4a616e2f32303039204368616e63656c6c6f72206f6e206272696e6b206f66207365636f6e64206261696c6f757420666f722062616e6b73)
 *     CTxOut(nValue=50.00000000, scriptPubKey=0x5F1DF16B2B704C8A578D0B)
 *   vMerkleTree: 4a5e1e
 */
static CBlock CreateGenesisBlock(uint32_t nTime, uint32_t nNonce, uint32_t nBits, int32_t nVersion, const CAmount& genesisReward)
{
    const char* pszTimestamp = "Mining made easy and accessible to all - Miners World Coin 2025";
    const CScript genesisOutputScript = CScript() << ParseHex("0443513a103dfb12d5183b51fb6f4a3096731e55fe5bdff47b76ca97a5f19257af45a24b378bfc158dc99c94b1c972e15f9d52174caf2fc95b5fe12fd2591705") << OP_CHECKSIG;
    return CreateGenesisBlock(pszTimestamp, genesisOutputScript, nTime, nNonce, nBits, nVersion, genesisReward);
}

void CChainParams::UpdateVersionBitsParameters(Consensus::DeploymentPos d, int64_t nStartTime, int64_t nTimeout)
{
    consensus.vDeployments[d].nStartTime = nStartTime;
    consensus.vDeployments[d].nTimeout = nTimeout;
}

/**
 * Main network
 */
/**
 * What makes a good checkpoint block?
 * + Is surrounded by blocks with reasonable timestamps
 *   (no blocks before with a timestamp after, none after with
 *    timestamp before)
 * + Contains no strange transactions
 */

class CMainParams : public CChainParams {
public:
    CMainParams() {
        strNetworkID = "main";
        consensus.nSubsidyHalvingInterval = 300000;
        consensus.BIP16Height = 0; // fixed
        consensus.BIP34Height = 0;
        consensus.BIP34Hash = uint256S("0x6be90b506f5cd197faa4f406911bff057974a634db063a358efe78a2c7c04f91"); // TODO: update with actual hash of block 0
        consensus.BIP65Height = 0;
        consensus.BIP66Height = 0;
        consensus.powLimit = uint256S("0x3fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
        consensus.nPowTargetTimespan = 14 * 24 * 60 * 60; // two weeks
        consensus.nPowTargetSpacing = 120;
        consensus.fPowAllowMinDifficultyBlocks = false;
        consensus.fPowNoRetargeting = false;
        consensus.nRuleChangeActivationThreshold = 75; 
        consensus.nMinerConfirmationWindow = 100; 
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].bit = 28;
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].nStartTime = 1199145601; // January 1, 2008
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].nTimeout = 1230767999; // December 31, 2008

        // Deployment of BIP68, BIP112, and BIP113.
        consensus.vDeployments[Consensus::DEPLOYMENT_CSV].bit = 0;
        consensus.vDeployments[Consensus::DEPLOYMENT_CSV].nStartTime = Consensus::BIP9Deployment::ALWAYS_ACTIVE;
        consensus.vDeployments[Consensus::DEPLOYMENT_CSV].nTimeout = 1778930000;    // May 8, 2033

        // Deployment of SegWit (BIP141, BIP143, and BIP147)
        consensus.vDeployments[Consensus::DEPLOYMENT_SEGWIT].bit = 1;
        consensus.vDeployments[Consensus::DEPLOYMENT_SEGWIT].nStartTime = Consensus::BIP9Deployment::ALWAYS_ACTIVE;
        consensus.vDeployments[Consensus::DEPLOYMENT_SEGWIT].nTimeout = 1778930000;   // Approx: May 16, 2026 @ 14:00 UTC


        // The best chain should have at least this much work.
		consensus.nMinimumChainWork = uint256S("0x0"); // 5

        // By default assume that the signatures in ancestors of this block are valid.
		consensus.defaultAssumeValid = uint256S("0x0"); // 5

        // 10% of Block reward to operations wallet
        nDeveloperFee = 10;
 
        // This is the block height when the devfee starts working
        nDeveloperFeeStart = 1;
  
        // Developer wallet address
        strDeveloperFeeAddress = std::string("97eFcPMFYCyH2Y2qY4tsUS6CkYwTZdQ2am");

        /**
         * The message start string is designed to be unlikely to occur in normal data.
         * The characters are rarely used upper ASCII, not valid as UTF-8, and produce
         * a large 32-bit integer with any alignment.
         */
        pchMessageStart[0] = 0xad;
        pchMessageStart[1] = 0x5a;
        pchMessageStart[2] = 0xeb;
        pchMessageStart[3] = 0x9f;
        nDefaultPort = 4408;
        nPruneAfterHeight = 100000;

        genesis = CreateGenesisBlock(1766563200, 70653, 0x1e3fffff, 1, 300 * COIN);
        consensus.hashGenesisBlock = genesis.GetHash();


        assert(consensus.hashGenesisBlock == uint256S("0x6be90b506f5cd197faa4f406911bff057974a634db063a358efe78a2c7c04f91"));
        assert(genesis.hashMerkleRoot == uint256S("0x896cddaacd3ab7a29cd01309a49dda3f9a83369161eaf941ab7b3e8ea5f0ff46"));

        // Note that of those which support the service bits prefix, most only support a subset of
        // possible options.
        // This is fine at runtime as we'll fall back to using them as a oneshot if they dont support the
        // service bits we want, but we should get them updated to support all service bits wanted by any
        // release ASAP to avoid it where possible.
	    vSeeds.emplace_back("seed.minersworldcoin.org");
        	

        base58Prefixes[PUBKEY_ADDRESS] = std::vector<unsigned char>(1, 20);   // 0x14
        base58Prefixes[SCRIPT_ADDRESS] = std::vector<unsigned char>(1, 10);   // 0x0A
        base58Prefixes[SECRET_KEY]     = std::vector<unsigned char>(1, 123);  // 0x7B
        base58Prefixes[EXT_PUBLIC_KEY] = {0x04, 0x88, 0xB2, 0x1E};
        base58Prefixes[EXT_SECRET_KEY] = {0x04, 0x88, 0xAD, 0xE4};

        bech32_hrp = "mwc";

        vFixedSeeds = std::vector<SeedSpec6>(pnSeed6_main, pnSeed6_main + ARRAYLEN(pnSeed6_main));

        fDefaultConsistencyChecks = false;
        fRequireStandard = true;
        fMineBlocksOnDemand = false;

        checkpointData = {
            {
                {0, uint256S("0x6be90b506f5cd197faa4f406911bff057974a634db063a358efe78a2c7c04f91")},
                   
            }
        };


/*
HELP - calculate
genesis = 1507032223
1528276166-1507032223=21243943

839317/21243943=

*/

        chainTxData = ChainTxData{
            // Data as of block 00000017fb4512999352c3ae0a9ea0aa0fc03e8118f74d4ece68df939bb33d93 (height 60000).
            1757327963, // * UNIX timestamp of last known number of transactions
            839317,    // * total number of transactions between genesis and that timestamp
                        //   (the tx=... number in the SetBestChain debug.log lines)
            0.0395 // * 0.0750 -  estimated number of transactions per second after that timestamp
        };
    }
};

/**
 * Testnet (v3)
 */
class CTestNetParams : public CChainParams {
public:
    CTestNetParams() {
        strNetworkID = "test";
        consensus.nSubsidyHalvingInterval = 300000;
        consensus.BIP16Height = 0; // fixed
        consensus.BIP34Height = 0;
        consensus.BIP34Hash = uint256S("0xb9e3c1d9b032f3bc24d3fb1649da6a4cba79722a25847c85ad8e60a7ba1e8d9c");
        consensus.BIP65Height = 0;
        consensus.BIP66Height = 0;
        consensus.powLimit = uint256S("0x3fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
        consensus.nPowTargetTimespan = 14 * 24 * 60 * 60; // two weeks
        consensus.nPowTargetSpacing = 120;
        //consensus.nZawyLwmaAveragingWindow = 90;
        consensus.fPowAllowMinDifficultyBlocks = true;
        consensus.fPowNoRetargeting = false;
        consensus.nRuleChangeActivationThreshold = 75; // 75%
        consensus.nMinerConfirmationWindow = 100; // nPowTargetTimespan / nPowTargetSpacing / 2
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].bit = 28;
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].nStartTime = 1199145601; // January 1, 2008
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].nTimeout = 1230767999; // December 31, 2008

        // Deployment of BIP68, BIP112, and BIP113.
        consensus.vDeployments[Consensus::DEPLOYMENT_CSV].bit = 0;
        consensus.vDeployments[Consensus::DEPLOYMENT_CSV].nStartTime = Consensus::BIP9Deployment::ALWAYS_ACTIVE;
        consensus.vDeployments[Consensus::DEPLOYMENT_CSV].nTimeout = 1778930000; // Approx: May 16, 2026 @ 14:00 UTC

        // Deployment of SegWit (BIP141, BIP143, and BIP147)
        consensus.vDeployments[Consensus::DEPLOYMENT_SEGWIT].bit = 1;
        consensus.vDeployments[Consensus::DEPLOYMENT_SEGWIT].nStartTime = Consensus::BIP9Deployment::ALWAYS_ACTIVE;
        consensus.vDeployments[Consensus::DEPLOYMENT_SEGWIT].nTimeout = 1778930000; // Approx: May 16, 2026 @ 14:00 UTC

        // The best chain should have at least this much work.
        consensus.nMinimumChainWork = uint256S("0x00");

        // By default assume that the signatures in ancestors of this block are valid.
        consensus.defaultAssumeValid = uint256S("0x00");

        // Disable dev fee on testnet
        nDeveloperFee = 0;
        nDeveloperFeeStart = std::numeric_limits<int>::max();
        strDeveloperFeeAddress.clear();

        pchMessageStart[0] = 0x95;
        pchMessageStart[1] = 0x54;
        pchMessageStart[2] = 0xe4;
        pchMessageStart[3] = 0x95;
        nDefaultPort = 14408;
        nPruneAfterHeight = 1000;

        genesis = CreateGenesisBlock(1766563500, 109730, 0x1e3fffff, 1, 300 * COIN);
        consensus.hashGenesisBlock = genesis.GetHash();

        assert(consensus.hashGenesisBlock == uint256S("0xb9e3c1d9b032f3bc24d3fb1649da6a4cba79722a25847c85ad8e60a7ba1e8d9c"));
        assert(genesis.hashMerkleRoot == uint256S("0x896cddaacd3ab7a29cd01309a49dda3f9a83369161eaf941ab7b3e8ea5f0ff46"));

        vFixedSeeds.clear();
        vSeeds.clear();
        // nodes with support for servicebits filtering should be at the top
        
        // vSeeds.emplace_back("157.180.76.198");
        //vSeeds.emplace_back("seed.minersworldcoin.org", false);
        //vSeeds.emplace_back("testnet-seed.minersworldcoin.jp", false);
        

        base58Prefixes[PUBKEY_ADDRESS] = std::vector<unsigned char>(1,83);
        base58Prefixes[SCRIPT_ADDRESS] = std::vector<unsigned char>(1,197);
        base58Prefixes[SECRET_KEY] =     std::vector<unsigned char>(1,240);
        base58Prefixes[EXT_PUBLIC_KEY] = {0x04, 0x35, 0x87, 0xCF};
        base58Prefixes[EXT_SECRET_KEY] = {0x04, 0x35, 0x83, 0x94};

        bech32_hrp = "tmwc";

        //vFixedSeeds = std::vector<SeedSpec6>(pnSeed6_test, pnSeed6_test + ARRAYLEN(pnSeed6_test));

        fDefaultConsistencyChecks = false;
        fRequireStandard = false;
        fMineBlocksOnDemand = false;


        checkpointData = {
            {
                {0, uint256S("0xb9e3c1d9b032f3bc24d3fb1649da6a4cba79722a25847c85ad8e60a7ba1e8d9c")},
                
            }
        };

        chainTxData = ChainTxData{
            0,
            0,
            0
        };

    }
};

/**
 * Regression test
 */
class CRegTestParams : public CChainParams {
public:
    CRegTestParams() {
        strNetworkID = "regtest";
        consensus.nSubsidyHalvingInterval = 150;
        consensus.BIP16Height = 0; // fixed
        consensus.BIP34Height = 100000000; // BIP34 has not activated on regtest (far in the future so block v1 are not rejected in tests)
        consensus.BIP34Hash = uint256();
        consensus.BIP65Height = 1351; // BIP65 activated on regtest (Used in rpc activation tests)
        consensus.BIP66Height = 1251; // BIP66 activated on regtest (Used in rpc activation tests)
        consensus.powLimit = uint256S("0x3fffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
        consensus.nPowTargetTimespan = 14 * 24 * 60 * 60; // two weeks
        consensus.nPowTargetSpacing = 120;
        //consensus.nZawyLwmaAveragingWindow = 90;
        consensus.fPowAllowMinDifficultyBlocks = true;
        consensus.fPowNoRetargeting = true;
        consensus.nRuleChangeActivationThreshold = 108; // 75% for testchains
        consensus.nMinerConfirmationWindow = 144; // Faster than normal for regtest (144 instead of 2016)
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].bit = 28;
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].nStartTime = 0;
        consensus.vDeployments[Consensus::DEPLOYMENT_TESTDUMMY].nTimeout = 999999999999ULL;
        consensus.vDeployments[Consensus::DEPLOYMENT_CSV].bit = 0;
        consensus.vDeployments[Consensus::DEPLOYMENT_CSV].nStartTime = 0;
        consensus.vDeployments[Consensus::DEPLOYMENT_CSV].nTimeout = 999999999999ULL;
        consensus.vDeployments[Consensus::DEPLOYMENT_SEGWIT].bit = 1;
        consensus.vDeployments[Consensus::DEPLOYMENT_SEGWIT].nStartTime = 0;
        consensus.vDeployments[Consensus::DEPLOYMENT_SEGWIT].nTimeout = 999999999999ULL;

        // The best chain should have at least this much work.
        consensus.nMinimumChainWork = uint256S("0x00");

        // By default assume that the signatures in ancestors of this block are valid.
        consensus.defaultAssumeValid = uint256S("0x00");

        // Disable dev fee on regtest
        nDeveloperFee = 0;
        nDeveloperFeeStart = std::numeric_limits<int>::max();
        strDeveloperFeeAddress.clear();

        pchMessageStart[0] = 0xaf;
        pchMessageStart[1] = 0xfb;
        pchMessageStart[2] = 0x5b;
        pchMessageStart[3] = 0xad;
        nDefaultPort = 24408;
        nPruneAfterHeight = 1000;

        genesis = CreateGenesisBlock(1766563800, 0, 0x207fffff, 1, 300 * COIN);
        consensus.hashGenesisBlock = genesis.GetHash();

        assert(consensus.hashGenesisBlock == uint256S("0xf6bc125187883de1cbedd1979c90609ead9f2c102bafd9d3ea9d83599fb8d334"));
        assert(genesis.hashMerkleRoot == uint256S("0x896cddaacd3ab7a29cd01309a49dda3f9a83369161eaf941ab7b3e8ea5f0ff46"));

        vFixedSeeds.clear(); //!< Regtest mode doesn't have any fixed seeds.
        vSeeds.clear();      //!< Regtest mode doesn't have any DNS seeds.

        fDefaultConsistencyChecks = true;
        fRequireStandard = false;
        fMineBlocksOnDemand = true;

        checkpointData = {
            {
                {0, uint256S("0xf6bc125187883de1cbedd1979c90609ead9f2c102bafd9d3ea9d83599fb8d334")},
            }
        };

        chainTxData = ChainTxData{
            0,
            0,
            0
        };

        base58Prefixes[PUBKEY_ADDRESS] = std::vector<unsigned char>(1,83);
        base58Prefixes[SCRIPT_ADDRESS] = std::vector<unsigned char>(1,197);
        base58Prefixes[SECRET_KEY] =     std::vector<unsigned char>(1,240);
        base58Prefixes[EXT_PUBLIC_KEY] = {0x04, 0x35, 0x87, 0xCF};
        base58Prefixes[EXT_SECRET_KEY] = {0x04, 0x35, 0x83, 0x94};

        bech32_hrp = "rmwc";
    }
};

static std::unique_ptr<CChainParams> globalChainParams;

const CChainParams &Params() {
    assert(globalChainParams);
    return *globalChainParams;
}

std::unique_ptr<CChainParams> CreateChainParams(const std::string& chain)
{
    if (chain == CBaseChainParams::MAIN)
        return std::unique_ptr<CChainParams>(new CMainParams());
    else if (chain == CBaseChainParams::TESTNET)
        return std::unique_ptr<CChainParams>(new CTestNetParams());
    else if (chain == CBaseChainParams::REGTEST)
        return std::unique_ptr<CChainParams>(new CRegTestParams());
    throw std::runtime_error(strprintf("%s: Unknown chain %s.", __func__, chain));
}

void SelectParams(const std::string& network)
{
    SelectBaseParams(network);
    globalChainParams = CreateChainParams(network);
}

void UpdateVersionBitsParameters(Consensus::DeploymentPos d, int64_t nStartTime, int64_t nTimeout)
{
    globalChainParams->UpdateVersionBitsParameters(d, nStartTime, nTimeout);
}
